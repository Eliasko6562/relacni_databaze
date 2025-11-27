from faker import Faker
import random
from datetime import datetime, timedelta

fake = Faker("cs_CZ")
random.seed(42)

# CONFIG
NUM_AGE_CATEGORIES = 4
NUM_TEAMS = 6
NUM_DISCIPLINES = 5
NUM_COACHES = NUM_TEAMS
NUM_RACE_EVENTS = 4
NUM_SWIMMERS = 40
NUM_RACES = 12
NUM_RACE_SWIMMER_LINKS = 80

def sql_val(v):
    if v is None:
        return "NULL"
    if isinstance(v, int):
        return str(v)
    return "'" + str(v).replace("'", "''") + "'"

def rand_date(start_days_ago=3650, end_days_ago=365):
    start = datetime.now() - timedelta(days=start_days_ago)
    end = datetime.now() - timedelta(days=end_days_ago)
    return fake.date_between(start_date=start, end_date=end).strftime('%Y-%m-%d')

def rand_time():
    return fake.time_object().strftime("%H:%M:%S")

def rand_datetime_within(days_from_now=180):
    start = datetime.now()
    end = datetime.now() + timedelta(days=days_from_now)
    return fake.date_time_between(start_date=start, end_date=end).strftime('%Y-%m-%d %H:%M:%S')

# ==========================================================
# AGE CATEGORY
# ==========================================================
age_defs = [("U12", 0, 11), ("U14", 12, 13), ("U16", 14, 15), ("Senior", 16, 99)]
age_category = [(i, name, mn, mx) for i, (name, mn, mx) in enumerate(age_defs, start=1)]

# ==========================================================
# TEAM
# ==========================================================
team = []
for i in range(1, NUM_TEAMS + 1):
    team.append((i, fake.company(), fake.country(), random.randint(8, 40)))

# ==========================================================
# DISCIPLINE
# ==========================================================
discipline_names = ["Butterfly", "Freestyle", "Backstroke", "Breaststroke", "IM"]
discipline = [(i, discipline_names[i-1]) for i in range(1, NUM_DISCIPLINES + 1)]

# ==========================================================
# RACE EVENTS
# ==========================================================
race_events = []
for i in range(1, NUM_RACE_EVENTS + 1):
    event_date = fake.date_between(start_date="+1d", end_date="+120d").strftime("%Y-%m-%d")
    start_time = rand_time()
    race_events.append((
        i,
        f"{fake.city()} Swim Meet #{i}",
        event_date,
        start_time,
        fake.city(),
        random.randint(150, 800)
    ))

# ==========================================================
# COACH
# ==========================================================
coach = []
for i in range(1, NUM_COACHES + 1):
    birth = rand_date(start_days_ago=22000, end_days_ago=10000)
    coach.append((
        i,
        i,  # one coach per team
        fake.first_name(),
        fake.last_name(),
        birth,
        fake.phone_number(),
        fake.email()
    ))

# ==========================================================
# SWIMMERS
# ==========================================================
swimmer = []
for i in range(1, NUM_SWIMMERS + 1):
    cat = random.choice(age_category)[0]
    tm = random.choice(team)[0]
    birth = rand_date(start_days_ago=8000, end_days_ago=3000)
    height = random.randint(130, 200)
    weight = random.randint(35, 95)

    swimmer.append((
        i,
        fake.first_name(),
        fake.last_name(),
        birth,
        height,
        weight,
        cat,
        tm
    ))

# ==========================================================
# RACES
# ==========================================================
race = []
for i in range(1, NUM_RACES + 1):
    event_id = random.choice(race_events)[0]
    discipline_id = random.choice(discipline)[0]
    category_id = random.choice(age_category)[0]
    race_start = rand_datetime_within(120)

    race.append((i, event_id, race_start, discipline_id, category_id))

# ==========================================================
# RACE-SWIMMER
# ==========================================================
race_swimmer = set()
attempts = 0

while len(race_swimmer) < NUM_RACE_SWIMMER_LINKS and attempts < NUM_RACE_SWIMMER_LINKS * 20:
    attempts += 1

    r = random.choice(race)
    matching_swimmers = [s for s in swimmer if s[6] == r[4]]
    if matching_swimmers:
        s = random.choice(matching_swimmers)
    else:
        s = random.choice(swimmer)

    race_swimmer.add((r[0], s[0]))

race_swimmer = list(race_swimmer)

# ==========================================================
# SQL OUTPUT
# ==========================================================
sql_lines = []

def insert_lines(table, columns, rows):
    sql_lines.append(f"-- {table}")
    cols = ", ".join(columns)
    for row in rows:
        vals = ", ".join(sql_val(v) for v in row)
        sql_lines.append(f"INSERT INTO {table} ({cols}) VALUES ({vals});")
    sql_lines.append("")

insert_lines("age_category", ["category_id", "name", "min_age", "max_age"], age_category)
insert_lines("team", ["team_id", "name", "country"], team)
insert_lines("discipline", ["discipline_id", "name"], discipline)
insert_lines("race_events", ["event_id", "name", "event_date", "start_time", "location", "price"], race_events)
insert_lines("coach", ["coach_id", "team_id", "first_name", "surname", "birthdate", "telephone", "email"], coach)
insert_lines("swimmer", ["swimmer_id", "first_name", "surname", "birthdate", "height", "weight", "category_id", "team_id"], swimmer)
insert_lines("race", ["race_id", "event_id", "race_start", "discipline_id", "category_id"], race)
insert_lines("race_swimmer", ["race_id", "swimmer_id"], race_swimmer)

output_path = "swim_demo_dataNEW.sql"
with open(output_path, "w", encoding="utf-8") as f:
    f.write("\n".join(sql_lines))


output_path
