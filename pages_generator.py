#!/usr/bin/env python

import cx_Oracle
import jinja2
import time


templateLoader = jinja2.FileSystemLoader(searchpath="templates")
templateEnv = jinja2.Environment(loader=templateLoader)
connection = cx_Oracle.connect('ionut/Passw0rd@192.168.137.174:1521/orcl')

refresh_time = 1000  # miliseconds

while True:
    classes_template = templateEnv.get_template("classes.jinja")
    cursor = connection.cursor()
    cursor.execute('SELECT * FROM Class')
    classes = []
    for row in cursor:
        classes.append({
            'name': row[1],
            'category_count': row[2]
        })
    cursor.close()
    with open("hugo_site/content/Classes.md", 'r') as f:
        content = f.read()
    new_content = classes_template.render(classes=classes)
    if new_content != content:
        with open("hugo_site/content/Classes.md", 'w') as f:
            f.write(new_content)

    categories_template = templateEnv.get_template("categories.jinja")
    cursor = connection.cursor()
    cursor.execute('SELECT * FROM Category')
    categories = []
    for row in cursor:
        categories.append({
            'name': row[1],
            'items_count': row[2]
        })
    cursor.close()
    with open("hugo_site/content/Categories.md", 'r') as f:
        content = f.read()
    new_content = categories_template.render(categories=categories)
    if new_content != content:
        with open("hugo_site/content/Categories.md", 'w') as f:
            f.write(new_content)

    items_template = templateEnv.get_template("items.jinja")
    cursor = connection.cursor()
    cursor.execute('SELECT * FROM Item')
    items = []
    for row in cursor:
        cur_cursor = connection.cursor()
        cur_cursor.execute('SELECT * FROM Category WHERE CID=%s' % row[1])
        category_name = cur_cursor.fetchone()[1]
        items.append({
            'name': row[2],
            'category_name': category_name,
            'description': row[3],
            'stock': row[4]
        })
        cur_cursor.close()
    cursor.close()
    with open("hugo_site/content/Items.md", 'r') as f:
        content = f.read()
    new_content = items_template.render(items=items)
    if new_content != content:
        with open("hugo_site/content/Items.md", 'w') as f:
            f.write(new_content)

    print "Sleeping %s ms before refreshing again." % (refresh_time)
    time.sleep(refresh_time/1000.0)

connection.close()
