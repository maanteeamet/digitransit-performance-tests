import random

def main():
    with open('test_data_otp.txt', 'w') as the_file:
        i = 0
        while i < 1000:
            random_row = 'https://api.dev.peatus.ee/routing/v1/routers/estonia/index/graphql POST { stop(code: "' + str(random.randint(10001, 50020)) + '-1") { name lat lon wheelchairAccessible } }'
            the_file.write(random_row + '\n')
            i += 1

if __name__ == "__main__":
    main()