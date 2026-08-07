import re

with open('russian_bus_stops.dart', 'r', encoding='utf-8-sig') as f:
    content = f.read()

stops = len(re.findall(r'BusStop\(', content))
routes = len(re.findall(r'BusRoute\(', content))
cities = set(re.findall(r"city: '([^']+)'", content))

with open('verify_result.txt', 'w', encoding='utf-8') as out:
    out.write(f'Stops: {stops}\n')
    out.write(f'Routes: {routes}\n')
    out.write(f'Cities: {len(cities)}\n')
    for c in sorted(cities):
        out.write(f'  - {c}\n')
    out.write(f'Starts with class: {content.startswith("class BusRoute")}\n')
    out.write(f'Ends with ];: {content.strip().endswith("];")}\n')
