
import System.IO
import System.Directory
import Terminal
import Mensagens


sobrescreve :: IO()
sobrescreve  = do
	writeFile "nomes.txt" ("")
	writeFile "destinos.txt" ("")
	writeFile "codigos.txt" ("")
	
atualizaArquivo :: [String] -> [String] -> [String] -> IO()
atualizaArquivo [] [] [] = putStrLn "Terminal atualizado"
atualizaArquivo [""] [""] [""] = putStrLn "Terminal atualizado"
atualizaArquivo [""] [""] []= putStrLn "Terminal atualizado"
atualizaArquivo [""] [] [""]= putStrLn "Terminal atualizado"
atualizaArquivo [""] [] []= putStrLn "Terminal atualizado"
atualizaArquivo [] [""] [""]= putStrLn "Terminal atualizado"
atualizaArquivo [] [""] []= putStrLn "Terminal atualizado"
atualizaArquivo [] [] [""]= putStrLn "Terminal atualizado"
atualizaArquivo (x:xs) (y:ys) (z:zs)  = do
	Terminal.salvaTicket x y z
	atualizaArquivo xs ys zs
apagaArquivos:: IO()
apagaArquivos = do	
		b <- removeFile "codigos.txt"
		c <- removeFile "destinos.txt"	
		a <- removeFile "nomes.txt"	
		putStrLn "Contato excluido"
	
getIndice :: String -> [String] -> Int ->  Int
getIndice n [] num= 0
getIndice n (nome:nomes) num = do
	if(n == nome) then do
		num
	else do
		getIndice n nomes num+1	
	
main = do
	Mensagens.printOpcoes
	opcao <-  getLine
	if(opcao== "1") then do
		putStrLn "Digite o codigo da passagem:"
 		codigo <- getLine
 		putStrLn "Digite o nome do passageiro:"
 		nome <- getLine
 		putStrLn "Digite o destino de viagem:"
 		destino <- getLine
 		
		Terminal.salvaTicket nome codigo destino
		
	else if ( opcao == "2") then do
		putStrLn "Digite o codigo da passagem:"
		codigo <- getLine
		(x:xs) <- readFile "nomes.txt" 
	
		(y:ys) <- readFile "codigos.txt" 
		
		(z:zs) <- readFile "destinos.txt" 
	
		let nomes =  Terminal.modelaArquivo (x:xs) "" []
		let codigos =  Terminal.modelaArquivo (y:ys) "" []
		let destinos =  Terminal.modelaArquivo (z:zs) "" []
		let index = getIndice codigo codigos 0
		if(index >= (length nomes)) then do
			putStrLn "Passagem nao cadastrada."
			putStrLn ""
		else do	
			putStr "Nome: "
			putStrLn (nomes!!index)
			putStr "Destino: "
			putStrLn (destinos!!index)
		
	else if((read opcao == 3)) then do
		---abrir arquivos para atualizar -----
		(x:xs) <- readFile "nomes.txt" 
	
		(y:ys) <- readFile "codigos.txt" 
		
		(z:zs) <- readFile "destinos.txt" 
		
		
		
		
		putStrLn "Digite o codigo da passagem."
		codigo <- getLine
		let nomes = Terminal.modelaArquivo (x:xs) "" []
		let codigos = Terminal.modelaArquivo (y:ys) "" []
		let destinos = Terminal.modelaArquivo (z:zs) "" []
		let index = getIndice codigo codigos 0
		
		if(index >= (length nomes)) then do
			putStrLn "Passagem não cadastrada."
			putStrLn ""
		else do	
			apagaArquivos
			sobrescreve 
			
			let novosNomes  = (take index nomes) ++ (drop (index+1) nomes)
			let novosCodigos =  (take index codigos) ++ (drop (index+1) codigos)
			let novosDestinos =  (take index destinos) ++ (drop (index+1) destinos)
			atualizaArquivo novosNomes novosCodigos novosDestinos
	else
		print "Invalida"
	main 
