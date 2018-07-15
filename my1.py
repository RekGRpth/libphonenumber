with open('clean.csv', 'w', encoding='utf-8') as out:
    for name in (
        'ABC-3x.csv',
        'ABC-4x.csv',
        'ABC-8x.csv',
        'DEF-9x.csv',
    ):
        print(name)
        with open(name, 'r', encoding='utf-8') as file:
            n = 0
            a = ''
            b = ''
            c = ''
            d = ''
            for line in file:
                n += 1
                if n == 1: continue
                line = line.strip().replace('г. ', 'г.').replace(' - ', '-').replace('г.о. ', 'г.о.').replace('|', ';').split(';')
                print(line)
                descr = ', '.join(line[5:])
#                for p in (
#                    '3452', # Тюмень
#                    '8', # специальный
#                    '9', # сотовый
#                ):
#                    if (line[0] + line[1]).startswith(p): descr = ', '.join(line[4:])
#                if a == line[0] and int(c) + 1 == int(line[1]) and d == descr:
                if a == line[0] and d == descr:
                    c = line[2]
                    continue
                elif a != '': out.write('%s;%s;%s;%s\n' % (a, b, c, d))
                else: out.write('%s;%s;%s;%s\n' % (line[0], line[1], line[2], descr))
                a = line[0]
                b = line[1]
                c = line[2]
                d = descr
            out.write('%s;%s;%s;%s\n' % (a, b, c, d))
