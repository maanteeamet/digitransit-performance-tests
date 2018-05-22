import random

def main():
    with open('kunnat') as f:
        content = f.readlines()

    content = [x.strip() for x in content] 
    with open('test_data_pelias.txt', 'w') as file1:
        for line in content:
            file1.write('http://pelias-api.marathon.l4lb.thisdcos.directory:8080/v1/search?text='+ line + '\n')
        i = 0
        while i < 100000:
            request_url = 'http://pelias-api.marathon.l4lb.thisdcos.directory:8080/v1/search?text=' + content[random.randint(0, 319)] + ',%20' + content[random.randint(0, 319)] + '\n'
            file1.write(request_url)
            i += 1

if __name__ == "__main__":
    main()