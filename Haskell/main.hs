import System.IO
import Data.List


userCadastrados = ["Adriano","Gustavo","Joao"]
destinos = ["MT","CG","JP","SS"]
passagem = ["456", "123", "321"]
main:: IO()
main = do
  mensagemBoasVindas
  putStrLn "Digite o nome de usuario para realizar login"
  user <- getLine
  let index = getIndice user userCadastrados 0

  if(index >= (length userCadastrados)) then do
			putStrLn "usuario nao cadastrado.\n"
			main
  else do
		acaoUserLogado user
			
				
acaoUserLogado :: String -> IO()			
acaoUserLogado userLogado = do
	putStr "Bem vindo "
	putStrLn userLogado
	mensagemBoasVindas
	escolhaTerminal
	entrada <- getLine
	let ind = (read entrada) -1
			
	if((read entrada) >= 4) then do
		putStrLn "terminal nao cadastrado."
		putStrLn ""
		acaoUserLogado userLogado
	else do	
		putStr "Bem vindo ao terminal de "
		let aux =  (destinos!!ind)
		print (getInfo aux)
		acaoTerminal userLogado
					
acaoTerminal:: String -> IO()			
acaoTerminal userLogado = do 
	putStrLn "Para este terminal temos as seguintes opções:"
	putStrLn "1. Comprar ticket"
	putStrLn "2. Consulta Tickets"
	putStrLn "3. Cancelar ticket"
	opcao <-  getLine
	if(opcao== "1") then do
        putStr "Olá "
        putStr userLogado
        putStrLn " Digite o destino da viagem"
        op <- getLine
      
       
        let index = getIndice op destinos 0
       
        if(index >= (length cidades)) then do
            putStrLn "destino não cadastrado."
            acaoTerminal userLogado
        else do
            print "ticket cadastrado com sucesso!"
            acaoTerminal userLogado
       
	else if ( opcao == "2") then do
        putStrLn "Digite o codigo da passagem:"
        codigo <- getLine
        let index = getIndice codigo passagem 0
        if(index >= (length passagem)) then do
            putStrLn "passagem não cadastrada."
            acaoTerminal userLogado
        else do
            putStr "Nome: "
            putStrLn (userCadastrados!!index)
            putStr "Destino: "
            putStrLn (destinos!!index)
            acaoTerminal userLogado
       
	else if((read opcao == 3)) then do
       
		putStrLn "Digite o codigo da passagem:"
		codigo <- getLine
		let index  = getIndice codigo passagem 0
		if(index >= (length passagem)) then do
			putStrLn "passagem não cadastrada."
			acaoTerminal userLogado
		else do
			print "ticket removido com sucesso!"
			main
       
       
 
           
	else do
		print "Invalida"
		acaoTerminal userLogado


getIndice :: String -> [String] -> Int ->  Int
getIndice n [] num= 0
getIndice n (nome:nomes) num = do
	if(n == nome) then do
		num
	else do
		getIndice n nomes num+1	




mensagemBoasVindas = putStrLn "======================\n----- Bem vindo! -----\n======================"

escolhaTerminal = putStrLn "Em qual terminal você se encontra?\n1. MONTEIRO\n2. CAMPINA GRANDE\n3. JOAO PESSOA\n4. SOUSA\n======================\nOpção:"


-- TERMINAL


taxa = 1.5

split str = case break (=='-') str of
                (a, _comma:b) -> a : split b
                (a, _empty)   -> [a]


toString :: [String] -> IO ()
toString array = mapM_ (putStrLn.show) array


selec_prim [x, _] = x
selec_sec [_, xs] = xs

reverseList [] = []
reverseList (x:xs) = reverseList xs ++ [x]


getCidadeByCodigo :: (String, String) -> [String] -> String -- metodo auxiliar
getCidadeByCodigo (cod,cidade) sigla
      | (cod == selec_prim sigla) = cidade
      | (cod == selec_sec sigla) = cidade
      | otherwise = ""

lista [] sigla = [] -- metodo auxiliar
lista (x:xs) sigla
  | (getCidadeByCodigo x sigla) == "" = lista xs sigla
  | otherwise = getCidadeByCodigo x sigla : lista xs sigla

concatenate:: [String] -> String -- metodo auxiliar
concatenate cidades = intercalate " - " cidades

-- PARA ACESSO DIGITAR SIGLA SEM ESPACO ENTRE AS SIGLAS DE CADA CIDADE EX.: "CG-SS" E NÃO "CG - SS"
getCidadeFinal:: String -> String
getCidadeFinal codigoByUsuario =
  concatenate (lista cidades (split codigoByUsuario))

empresas = ["Real Bus", "Viacao Sao Jose", "Pontual Transporte", "Travel Bus"]
rotas = [("MT-CG","CG-MT"),("CG-JP","JP-CG"),("MT-JP","JP-MT"),("MT-SS","SS-MT"),("SS-CG","CG-SS"),("SS-JP","JP-SS")]

busca_prim (x, _) = x
busca_sec (_, xs) = xs

getValoresByCodigo :: (String, String) -> String -> Int -- metodo auxiliar
getValoresByCodigo (sigla1,sigla2) siglaRota
      | (sigla1 == siglaRota) = 1
      | (sigla2 == siglaRota) = 2
      | otherwise = 0

searchRota [] sigla = 0
searchRota (x:xs) sigla -- metodo auxiliar
      | (getValoresByCodigo x sigla) == 0 = 1 + (searchRota xs sigla)
      | otherwise = 1 + (getValoresByCodigo x sigla)

retornaPrecos:: String -> Float -- metodo auxiliar
retornaPrecos sigla
      | (searchRota rotas sigla) <= 3 = 26.0
      | (searchRota rotas sigla) <= 5 = 28.0
      | (searchRota rotas sigla) <= 6 = 32.0
      | otherwise = 35.0

cidades = [("MT","MONTEIRO"),("CG","CAMPINA GRANDE"),("JP","JOAO PESSOA"),("SS","SOUSA")]
destinosEValores :: (String,String) -> [String] -- metodo auxiliar
destinosEValores (sigla1, sigla2) =
      [getCidadeFinal sigla1 ++ " - R$ " ++ show (retornaPrecos sigla1)] ++ [getCidadeFinal sigla2 ++ " - R$ " ++ show (retornaPrecos sigla2)]


listaRotas [] = [] -- FUNCAO FINAL A SER UTILIZADA, ENTRADA É A LISTA 'ROTAS'
listaRotas (x:xs) = destinosEValores x : listaRotas xs

getTaxaDeEmbarque :: Int -> Float
getTaxaDeEmbarque qtdMalas = fromIntegral (qtdMalas) * taxa

getNomeCidade [] sigla = []
getNomeCidade (x:xs) sigla
      | sigla == (busca_prim x) = busca_sec x
      | otherwise = getNomeCidade xs sigla

getInfo :: String -> String -- -- FUNCAO FINAL A SER UTILIZADA, ENTRADA É A SIGLA DO TERMINAL DE ONDE ESTA SENDO FEITA A OPERACAO, EX.: "CG"
getInfo codigo = "Terminal Rodoviario de " ++ (getNomeCidade cidades codigo) ++ " Empresas disponiveis: Real Bus, Viacao Sao Jose, Pontual Transporte, Travel Bus"