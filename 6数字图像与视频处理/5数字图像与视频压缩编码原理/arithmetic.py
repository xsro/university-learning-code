def get_dict_from_singal():
    singal_dict = {}
    singal_dict['A'] = (0, 0.1)
    singal_dict['B'] = (0.1, 0.5)
    singal_dict['C'] = (0.5, 0.7)
    singal_dict['D'] = (0.7, 1)
    return singal_dict


def encoder(singal, singal_dict):
    Low = 0
    High = 1
    for s in singal:
        CodeRange = High - Low
        High = Low + CodeRange * singal_dict[s][1]
        Low = Low + CodeRange * singal_dict[s][0]
    return Low


def decoder(encoded_number, singal_dict, singal_length):
    singal = []
    while singal_length:
        for k, v in singal_dict.items():
            if v[0] <= encoded_number < v[1]:
                singal.append(k)
                range = v[1] - v[0]
                encoded_number -= v[0]
                encoded_number /= range
                break
        singal_length -= 1
    return singal


singal_dict = {}
singal_dict['a'] = (0, 0.4)
singal_dict['b'] = (0.4, 0.6)
singal_dict['c'] = (0.6, 0.7)
singal_dict['d'] = (0.7, 1)
singal = 'dacab'
low = encoder(singal, singal_dict)
singal_rec = decoder(low, singal_dict, len(singal))
print(singal_rec)