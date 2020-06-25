def closed_range(start, stop, step=1):
  dir = 1 if (step > 0) else -1
  return range(start, stop + dir, step)

def main():
    with open('test_data_map.txt', 'w') as the_file:
        #general country outline
        zoom = 9
        for x in closed_range(286, 296):
            for y in closed_range(149, 155):
                tile_url = 'https://api.dev.peatus.ee/map/v1/hsl-map/' + str(zoom) + '/' + str(x) + '/' + str(y) + '.png'
                the_file.write(tile_url + '\n')
        #major cities in zoom 11-17
        tallinnX1 = 1163
        tallinnX2 = 1167
        tallinnY1 = 598
        tallinnY2 = 602
        tartuX1 = 1175
        tartuX2 = 1176
        tartuY1 = 612
        tartuY2 = 613
        p2rnuX1 = 1162
        p2rnuX2 = 1164
        p2rnuY1 = 612
        p2rnuY2 = 613
        for zoom in closed_range(11, 17):
            ##tallinn
            print(tallinnX1)
            for x in closed_range(tallinnX1, tallinnX2):
                for y in closed_range(tallinnY1, tallinnY2):
                    tile_url = 'https://api.dev.peatus.ee/map/v1/hsl-map/' + str(zoom) + '/' + str(x) + '/' + str(y) + '.png'
                    the_file.write(tile_url + '\n')
            #increment tallinn coordinates
            tallinnX1 = tallinnX1 * 2
            tallinnX2 = tallinnX2 * 2 + 1
            tallinnY1 = tallinnY1 * 2
            tallinnY2 = tallinnY2 * 2 + 1
            ##tartu
            for x in closed_range(tartuX1, tartuX2):
                for y in closed_range(tartuY1, tartuY2):
                    tile_url = 'https://api.dev.peatus.ee/map/v1/hsl-map/' + str(zoom) + '/' + str(x) + '/' + str(y) + '.png'
                    the_file.write(tile_url + '\n')
            #increment tartu coordinates
            tartuX1 = tartuX1 * 2
            tartuX2 = tartuX2 * 2 + 1
            tartuY1 = tartuY1 * 2
            tartuY2 = tartuY2 * 2 + 1
            ##pärnu
            for x in closed_range(p2rnuX1, p2rnuX2):
                for y in closed_range(p2rnuY1, p2rnuY2):
                    tile_url = 'https://api.dev.peatus.ee/map/v1/hsl-map/' + str(zoom) + '/' + str(x) + '/' + str(y) + '.png'
                    the_file.write(tile_url + '\n')
            #increment pärnu coordinates
            p2rnuX1 = p2rnuX1 * 2
            p2rnuX2 = p2rnuX2 * 2 + 1
            p2rnuY1 = p2rnuY1 * 2
            p2rnuY2 = p2rnuY2 * 2 + 1

if __name__ == "__main__":
    main()