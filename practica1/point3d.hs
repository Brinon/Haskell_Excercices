--  Point  --
class Point p where
-- retorna el valor de la cordenada del primer parametre
  sel :: Int -> p -> Double
-- retorna la dimensio del punt 
  dim :: p -> Int
-- donats dos punts i una llista de coordenades seleccionades retorna el numero de fill de e2 q li toca a e1
  child :: p -> p -> [Int] -> Int
  cmp :: p -> p -> Int -> Int
-- retorna la distancia entre dos punts
  dist :: p -> p -> Double
-- crea un punt a partir duna llista
  listToPoint :: [Double] -> p



-- Point3d --
data Point3d = Point3d [Double]

  
instance Eq Point3d where
  e1 == e2 = 0.0 == dist e1 e2
  
instance Show Point3d where
  show (Point3d [d1,d2,d3]) = "(" ++ (show d1) ++ "," ++ (show d2) ++ "," ++ (show d3) ++")"


instance Point Point3d where
  
  sel x (Point3d l) = l !! x                      
  
  dim p = 3
  
  cmp e1 e2 x = if (sel (x-1) e2) > (sel (x-1) e1) then 1
                else 0
                     
  child e1 e2 l = valBin l2
    where l2 = map (cmp e1 e2) l
          
  dist (Point3d [x1,y1,z1]) (Point3d [x2,y2,z2]) = sqrt ((x2 - x1) ** 2) + ((y2 - y1) ** 2) + ((z2 - z1) ** 2) 
  
  listToPoint l = (Point3d l)


  


-- rep una llista de 1 i 0, retorna el valor en decimal del nombre binari q representa
valBin :: [Int] -> Int
valBin [x] = x
valBin l = 2 * (valBin $ init l) + last l


-- Kd2nTree --
data Kd2nTree p = Node p [Int] [Kd2nTree p] | Empty

-- com els kd2ntrees son arbres de cerca, realment representen un conjunt de punts, aixi que no ens importa que tinguin la 
-- mateixa forma, nomes els mateixos elements
--instance Eq p => Eq (Kd2nTree p) where
--  (Kd2nTree l1) == (Kd2nTree l2) = 
--    and [length l1 == length l2, samePoints l1 l2]

--instance Show p => Show (Kd2nTree p) where
--  show :: Point p => Kd2nTree
--  show Node p1 lcoords lfills =
    
    
    
-- retorna el resultat d'inserir un punt al kd2ntree
insert :: Point p => Kd2nTree p -> p -> [Int] -> Kd2nTree p
insert Empty p l = Node p l (replicate x Empty)
  where x =  2 ^ length l
insert (Node p1 lcoords lfills) p2 lcoord2 = Node p1 lcoords (fillsAnt ++ [fill] ++ fillsSeg)
  where fillsAnt = take n lfills
        fillsSeg = drop (n+1) lfills 
        fill = insert (head (drop n lfills)) p2 lcoord2
        n = child p1 p2 lcoords

