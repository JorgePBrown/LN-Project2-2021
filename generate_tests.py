import sys
import random

number = sys.argv[1]
letters = ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'X', 'Z')

def num_transducer(sequence: str):
    res = ""
    i = 0
    for char in sequence:
        res += f"{i}\t{i+1}\t{char}\n"
        i += 1

    res += str(i)
    return res

def text_transducer(sequence: str):
    split = sequence.split(" ")
    res = ""
    i = 0
    for char in split:
        res += f"{i}\t{i+1}\t{char}\n"
        i += 1

    res += str(i)
    return res

def num_to_string_hora(num: int):
    return {
        0 : "zero",
        1 : "uma",
        2 : "duas",
        3 : "tres",
        4 : "quatro",
        5 : "cinco",
        6 : "seis",
        7 : "sete",
        8 : "oito",
        9 : "nove",
        10 : "dez",
        11 : "onze",
        12 : "doze",
        13 : "treze",
        14 : "catorze",
        15 : "quinze",
        16 : "dezasseis",
        17 : "dezassete",
        18 : "dezoito",
        19 : "dezanove",
        20 : "vinte",
        21 : "vinte e uma",
        22 : "vinte e duas",
        23 : "vinte e tres"
    }[num]

def num_to_string_minuto(num: int):
    return {
        0 : "zero",
        1 : "um",
        2 : "dois",
        3 : "tres",
        4 : "quatro",
        5 : "cinco",
        6 : "seis",
        7 : "sete",
        8 : "oito",
        9 : "nove",
        10 : "dez",
        11 : "onze",
        12 : "doze",
        13 : "treze",
        14 : "catorze",
        15 : "quinze",
        16 : "dezasseis",
        17 : "dezassete",
        18 : "dezoito",
        19 : "dezanove",
        20 : "vinte",
        21 : "vinte e um",
        22 : "vinte e dois",
        23 : "vinte e tres",
        24 : "vinte e quatro",
        25 : "vinte e cinco",
        26 : "vinte e seis",
        27 : "vinte e sete",
        28 : "vinte e oito",
        29 : "vinte e nove",
        30 : "trinta",
        31 : "trinta e um",
        32 : "trinta e dois",
        33 : "trinta e tres",
        34 : "trinta e quatro",
        35 : "trinta e cinco",
        36 : "trinta e seis",
        37 : "trinta e sete",
        38 : "trinta e oito",
        39 : "trinta e nove",
        40 : "quarenta",
        41 : "quarenta e um",
        42 : "quarenta e dois",
        43 : "quarenta e tres",
        44 : "quarenta e quatro",
        45 : "quarenta e cinco",
        46 : "quarenta e seis",
        47 : "quarenta e sete",
        48 : "quarenta e oito",
        49 : "quarenta e nove",
        50 : "cinquenta",
        51 : "cinquenta e um",
        52 : "cinquenta e dois",
        53 : "cinquenta e tres",
        54 : "cinquenta e quatro",
        55 : "cinquenta e cinco",
        56 : "cinquenta e seis",
        57 : "cinquenta e sete",
        58 : "cinquenta e oito",
        59 : "cinquenta e nove",
    }[num]

for letter in letters:
    # Sleep num
    with open(f"tests/sleep{letter}_{number}.txt", "w") as f:
        hours = random.randint(23, 25)
        if hours > 23:
            hours -= 24
        minutes = random.randint(0, 59)
        string = "%02d:%02d"%(hours, minutes)
        f.write(num_transducer(string))

    # Wake up text
    with open(f"tests/wakeup{letter}_{number}.txt", "w") as f:
        hours = random.randint(8, 13)
        minutes = random.randint(0, 59)
        hours_text = bool(random.randint(0, 1))
        minutes_text = bool(random.randint(0, 1))

        hours = num_to_string_hora(hours) + (" horas" if hours_text else "")

        rand = random.random()

        if minutes == 30 and rand < 0.8:
            minutes = " e meia"
        elif minutes == 15 and rand < 0.8:
            minutes = " e um quarto"
        elif minutes == 45 and rand < 0.8:
            minutes = " e tres quartos"
        elif minutes == 0 and rand < 0.8:
            minutes = ""
        else:
            minutes = " e " + num_to_string_minuto(minutes) + (" minutos" if hours_text else "")

        f.write(text_transducer(hours + minutes))