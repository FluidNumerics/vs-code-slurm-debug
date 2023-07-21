# A slightly more robust example script

def divide(a : float, b : float) -> float:
    try:
        c = a / b
    except ZeroDivisionError:
        raise ZeroDivisionError(f"YOU'RE TRYING TO DIVIDE BY ZERO !!!\nYOU CANNOT DIVIDE {a} BY {b} !!!")
    return c

def main():
    numerator = 1.0
    denominator = 0.0
    print(divide(numerator, denominator))

if __name__ == "__main__":
    main()
