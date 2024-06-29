import json
from sys import argv, exit
from docx import Document


def clean_text(text):
    '''
    Очистка от перевода строк
    '''
    return text.replace('\n', ' ')


def process(data):
    '''
    Замена строк
    '''
    data.insert(6, '')
    code = data[10]
    data[10] = code + ('.68' if code == '09.04.04' else '.62') + ' - Программная инженерия'
    data[11] = 'КАФЕДРА ПРОГРАММНОЙ ИНЖЕНЕРИИ'
    data[12] = '68 - Магистр' if code == '09.04.04' else '62 - Бакалавр'
    return data

document = Document(argv[1])
path = argv[2]
table = document.tables[0]
vkrs = []

keys = None
for i, row in enumerate(table.rows):
    text = (clean_text(cell.text) for cell in row.cells)
    if i == 0:
        continue
    vkrs.append(list(text))

res = []
for vkr in vkrs:
    vkr_name = vkr[1]
    vkr_theme = vkr[2]
    vkr_id = vkr[3]
    doc = Document(path + vkr_id + ".docx")
    tab = doc.tables[0]
    data = [clean_text(c.text) for c in tab.column_cells(1)]
    if data[0] != vkr_id:
        print('Шифр не совпадает', vkr_id, data[0])
        exit(1)
    if data[1] != vkr_name:
        print('ФИО не совпадает', vkr_name, data[1])
        exit(1)
    if data[4] != vkr_theme:
        print('Тема не совпадает', vkr_theme, data[4])
        exit(1)
    res.append(process(data))

print(json.dumps(res))
