def diap_to_prefix(a, b):
    def inner(aa, bb, p):
        if p == 1:
            if a <= aa <= b:
                yield aa
            return

        for d in range(aa, bb + 1, p):
            if a <= d and d + p - 1 <= b:
                yield d // p
            elif not (bb < a or aa > b):
                for i in range(10):
                    yield from inner(d + i * p // 10, d + (i + 1) * p // 10 - 1, p // 10)

    a, b = int(a), int(b)
    p = 10**(max(len(str(x)) for x in (a, b)) - 1)
    yield from inner(a // p * p, b // p * p + p - 1, p)

with open('resources/geocoding/ru/7.txt', 'w', encoding='utf-8') as out, open('clean.csv', 'r', encoding='utf-8') as file:
    n = 0
    p = ''
    for line in file:
        n += 1
        if n == 1: continue
        line = line.strip().split(';')
        print(line)
        for prefix in diap_to_prefix(line[0] + line[1], line[0] + line[2]):
            if p != str(prefix)[:8]: out.write('7%s|%s\n' % (str(prefix)[:8], ', '.join(line[3:])))
            p = str(prefix)[:8]
