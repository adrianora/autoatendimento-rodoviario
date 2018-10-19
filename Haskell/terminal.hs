import System.IO

cidades = [("MT","MONTEIRO"),("CG","CAMPINA GRANDE"),("JP","JOAO PESSOA"),("SS","SOUSA")]


split :: String -> Char -> [String]
split str delim = let (start, end) = break (== delim) str
                    in start : if null end then [] else split (tail end) delim

toString :: [String] -> IO ()
toString array = mapM_ (putStrLn.show) array


selec_prim (x, _) = x
selec_sec(_, y) = y

getCidadeByCodigo :: (String, String) -> String -> String
getCidadeByCodigo (cod,cidade) sigla
      | (cod == sigla) = cidade
      | otherwise = ""

lista [] sigla = []
lista (x:xs) sigla
  | (getCidadeByCodigo x sigla) == "" = lista xs sigla
  | otherwise = getCidadeByCodigo x sigla : lista xs sigla
