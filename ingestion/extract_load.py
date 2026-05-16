import kagglehub
import pandas as pd
import os
from sqlalchemy import create_engine


def createDFs(url):
    path = kagglehub.dataset_download(url)
    lista_nomes = [x for x in os.listdir(path)]
    lista_dfs = [pd.read_csv(os.path.join(path, x)) for x in lista_nomes]
    lista_nomes_tratados = [x[0:-4] for x in lista_nomes]
    return (lista_dfs, lista_nomes_tratados)


def createTables(dfs, nomes):
    engine = create_engine('postgresql://joalbo:joalbo@127.0.0.1:5433/dbtestes')
    for df, nome in zip(dfs, nomes):
        df.to_sql(nome, engine, if_exists='append', index=False)
    print("Load completed successfully.")


if __name__ == "__main__":
    lista_dfs, lista_nomes_tratados = createDFs("olistbr/brazilian-ecommerce")
    createTables(lista_dfs, lista_nomes_tratados)
