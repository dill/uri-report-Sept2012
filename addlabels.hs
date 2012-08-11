-- A Pandoc filter to turn the "link text" into Figure labels
-- in Latex output and parse `ref:xxx` into \ref{xxx} 
-- Matti Pastell 2011 <matti.pastell@helsinki.fi> 
-- Requires Pandoc 1.8
-- https://bitbucket.org/mpastell/pandoc-filters/src/6cd7b8522cf5/addlabels.hs


import Text.Pandoc
import Text.Pandoc.Shared

main = interact $ jsonFilter $ bottomUp addlabel . bottomUp refs

addlabel :: Block -> Block
addlabel (Para [Image xs (u, t)]) = RawBlock "latex"
          (concat [
          "\\begin{figure}[h]\n",
          "\\caption{" , (stringify xs) , "}\n" ,
          "\\includegraphics{" , u , "}\n" ,
--          "\\label{" , t ,  "}\n" ,
          "\\end{figure}"])
addlabel x=x


refs :: Inline -> Inline
refs (Code attr code) 
     | (take 4 code) == "ref:" = RawInline "tex" ("\\ref{" ++ (drop 4 code) ++ "}")
     | otherwise = Code attr code
refs x = x
