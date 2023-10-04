import pandas as pd
import matplotlib.pyplot as plt


def make_gen_dict(result):
    result = result[3:]
    gen_dict = {}

    gen_dict['1세대'] = result[0]
    gen_dict['2세대'] = result[1]
    gen_dict['3세대 이상'] = result[2] + result[3]
    gen_dict['1인'] = result[4]
    gen_dict['비친족'] = result[5]

    return gen_dict


def make_pie(gen_dict, title):
    labels = []
    values = []

    for k,v in gen_dict.items():
        labels.append(k)
        values.append(v)

    data = {'labels': labels, 'values': values}
    df = pd.DataFrame(data)

    df = df.sort_values(by='values', ascending=False)

    plt.figure(figsize=(8,8))

    _, _, autotexts = plt.pie(df['values'], 
                            labels=df['labels'], 
                            autopct='%.f%%',
                            startangle=90,
                            counterclock=False,
                            explode=[0.05, 0.05, 0.05, 0.05, 0.05],
                            shadow=True)

    for autotext in autotexts:
        autotext.set_color('white')
        autotext.set_weight('bold')

    plt.title(title)
    plt.show();


def show_label(region_list, x, y, x_text, y_text, position):
    texts = []
    for i, label in enumerate(region_list):
        texts.append(plt.annotate(label,
                                (x[i], y[i]),
                                textcoords='offset points',
                                xytext=(x_text, y_text),
                                ha=position)
                    )
    return texts