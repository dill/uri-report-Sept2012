-- Modified from:
-- https://bitbucket.org/mpastell/pandoc-filters/src/6cd7b8522cf5/addlabels.hs
--
-- "A Pandoc filter to turn the "link text" into Figure labels
-- in Latex output and parse `ref:xxx` into \ref{xxx} 
-- Matti Pastell 2011 <matti.pastell@helsinki.fi> 
-- Requires Pandoc 1.8"
--
-- Now -- moves the caption above the figure
--     -- removes Code formatting

import Text.Pandoc
import Text.Pandoc.Shared

main = interact $ jsonFilter $ bottomUp addlabel . bottomUp refs

addlabel :: Block -> Block
addlabel (Para [Image xs (u, t)]) = RawBlock "latex"
          (concat [
          "\\begin{figure}[h]\n",
          "\\caption{" , (stringify xs) , "}\n" ,
          "\\includegraphics{" , u , "}\n" ,
          "\\end{figure}"])
addlabel x=x


refs :: Inline -> Inline
refs (Code attr code) 
     | otherwise = Str code
refs x = x
