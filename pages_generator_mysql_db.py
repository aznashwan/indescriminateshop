#!/usr/bin/env python

import pymysql
import jinja2
import time


templateLoader = jinja2.FileSystemLoader(searchpath="templates")
templateEnv = jinja2.Environment(loader=templateLoader)
connection = pymysql.connect(host='10.7.133.183',
                             user='android_user',
                             password='Passw0rd',
                             db='android',
                             cursorclass=pymysql.cursors.DictCursor)


def render_file(file_path, template_name, **kwargs):
    template = templateEnv.get_template(template_name)
    with open(file_path, 'r') as f:
        content = f.read()
    new_content = template.render(**kwargs)
    if new_content != content:
        with open(file_path, 'w') as f:
            f.write(new_content)


refresh_time = 1000  # miliseconds
while True:
    connection.begin()
    cursor = connection.cursor()
    cursor.execute('SELECT * FROM class')
    classes = []
    for row in cursor:
        category_count = None
        with connection.cursor() as c:
            c.execute('select count(*) nr from cl2ca '
                      'where clid=%s' % row['id'])
            category_count = c.fetchone()['nr']
        classes.append({
            'name': row['name'],
            'category_count': category_count or 0
        })
    cursor.close()
    render_file(file_path="hugo_site/content/Classes.md",
                template_name="classes.jinja",
                classes=classes)

    cursor = connection.cursor()
    cursor.execute('SELECT * FROM category')
    categories = []
    for row in cursor:
        items_count = 0
        with connection.cursor() as c:
            c.execute('select count(*) nr from item where cid=%s' % row['id'])
            items_count = c.fetchone()['nr']
        categories.append({
            'name': row['name'],
            'items_count': items_count or 0
        })
    cursor.close()
    render_file(file_path="hugo_site/content/Categories.md",
                template_name="categories.jinja",
                categories=categories)

    cursor = connection.cursor()
    cursor.execute('SELECT * FROM item')
    items = []
    for row in cursor:
        category_name = None
        with connection.cursor() as c:
            c.execute('SELECT name FROM category WHERE id=%s' % row['cid'])
            category_name = c.fetchone()['name']
        items.append({
            'name': row['name'],
            'category_name': category_name or 'None',
            'description': row['description'],
            'stock': row['stock']
        })
    cursor.close()
    render_file(file_path="hugo_site/content/Items.md",
                template_name="items.jinja",
                items=items)

    print "Sleeping %s ms before refreshing again." % (refresh_time)
    time.sleep(refresh_time/1000.0)

connection.close()
