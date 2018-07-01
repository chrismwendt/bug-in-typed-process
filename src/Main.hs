import qualified System.Process as P
import qualified System.Process.Typed as T
import qualified Data.ByteString.Lazy as BL

-- `stack ghci`
-- > main
-- *The process finishes*
--
-- `stack build ; stack exec app`
-- *The process hangs!*

main = do
  putStrLn "System.Process with 10k works:"
  P.readCreateProcess (P.shell "sh -c \"yes | head -c 10000\"") "" >>= print . length

  putStrLn "System.Process.Typed with 10k also works:"
  T.readProcessStdout_ (T.shell "sh -c \"yes | head -c 10000\"") >>= print . BL.length

  putStrLn "System.Process with 100k works:"
  P.readCreateProcess (P.shell "sh -c \"yes | head -c 100000\"") "" >>= print . length

  putStrLn "System.Process.Typed with 100k works in ghci, but hangs (!) if compiled."
  putStrLn "When you Ctrl-C, you'll see ~65k lines printed (suspiciously close to 65536, a power of 2)."
  T.readProcessStdout_ (T.shell "sh -c \"yes | head -c 100000\"") >>= print . BL.length
