module BinaryIO(readBinaryFile,
                writeBinaryFile) where

import Data.ByteString.Char8 as Ch
import System.IO as IO
import System.IO.Strict as SIO

readBinaryFile :: FilePath -> IO ByteString
readBinaryFile path = do
  handle <- openFile path ReadMode
  hSetBinaryMode handle True
  contents <- SIO.hGetContents handle
  hClose handle
  return $ Ch.pack contents
  
writeBinaryFile :: ByteString -> FilePath -> IO ()
writeBinaryFile contents path = do
  handle <- openFile path WriteMode
  hSetBinaryMode handle True
  Ch.hPutStr handle contents
  hClose handle