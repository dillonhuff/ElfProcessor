module Main(main) where

import Control.Monad
import Data.ByteString as BS
import Data.ByteString.Char8 as Ch
import Data.Elf
import Data.List as L
import Text.Disassembler.X86Disassembler

import BinaryIO

main :: IO ()
main = 
  let extractElfBytes = BS.unpack . elfSectionData . L.head . L.filter (\sec -> (elfSectionName sec == ".text")) . elfSections . parseElf in
  do
    byteStr <- readBinaryFile "a.out"
    let bytes = extractElfBytes byteStr in
      do
        instrsOrErr <- disassembleList bytes
        case instrsOrErr of
          Left err -> Prelude.putStrLn $ show err
          Right instrs -> Prelude.putStrLn $ L.concatMap (\i -> (showAtt i) ++ "\n") instrs