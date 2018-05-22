import random

def main():
    with open('test_data_otp.txt', 'w') as the_file:
        i = 0
        while i < 1000:
            random_row = 'http://opentripplanner-hsl.marathon.l4lb.thisdcos.directory:8080/otp/routers/hsl/index/graphql POST { stop(id: "HSL:' + str(random.randint(1040000, 1050000)) + '") { name lat lon wheelchairBoarding } }'
            the_file.write(random_row + '\n')
            i += 1

if __name__ == "__main__":
    main()