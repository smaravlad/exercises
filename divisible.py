def check_if_divisible(number=100):
    """
    parameter: number
    returns:
    - counts backwards from 100 to 1 and prints:
        - “Software” if the number is divisible by 3
        - “Agile” if the number is divisible by 5
        - "Testing", if number is divisible by both
        - just the number if none of those cases are true.
    """
    for i in range(number, 0, -1):
        if i % 3 == 0 and i % 5 == 0:
            print("Testing")
        elif i % 3 == 0:
            print("Software")
        elif i % 5 == 0:
            print("Agile")
        else:
            print(i)


if __name__ == "__main__":
    check_if_divisible()
