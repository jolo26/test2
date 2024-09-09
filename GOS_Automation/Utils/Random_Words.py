import random
from datetime import datetime

def Get_Random_Package(game_type):
    with open("Utils\wordlist.txt") as file: 
        words = file.readlines() 
    if  game_type == 'Game':
        prefix = 'com.package.game.'
    if  game_type == 'Non Game':
        prefix = 'com.package.nongame.'
    if  game_type == 'Unknown':
        prefix = 'com.package.unknown.'
    random_list = random.sample(words, 1)  # Sample 10 random words from the file 
    # Clean up whitespace and newlines 
    random_list = [word.strip() for word in random_list]
    date = str(datetime.today().date()).replace('-','')
    package_name = prefix + random_list[0] + '.' + date
    return package_name

def Get_Random_Word():
    with open("Utils\wordlist.txt") as file: 
        words = file.readlines() 
    random_list = random.sample(words, 1)  # Sample 10 random words from the file 
    # Clean up whitespace and newlines 
    random_list = [word.strip() for word in random_list]
    return random_list[0]

def Get_Random_Password():
    with open("Utils\wordlist.txt") as file: 
        words = file.readlines() 
    random_list = random.sample(words, 1)  # Sample 10 random words from the file 
    # Clean up whitespace and newlines 
    random_list = [word.strip() for word in random_list]
    random_password = random_list[0].title() + '12#$'
    return random_password