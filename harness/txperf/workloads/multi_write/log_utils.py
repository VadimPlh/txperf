from enum import Enum

class State(Enum):
    INIT = 0
    STARTED = 1
    CONSTRUCTING = 2
    CONSTRUCTED = 3
    TX = 4
    COMMIT = 5
    OK = 6
    ERROR = 7
    EVENT = 8
    ABORT = 9

cmds = {
    "started": State.STARTED,
    "constructing": State.CONSTRUCTING,
    "constructed": State.CONSTRUCTED,
    "tx": State.TX,
    "cmt": State.COMMIT,
    "brt": State.ABORT,
    "ok": State.OK,
    "err": State.ERROR,
    "event": State.EVENT
}

threads = {
    "transferring": {
        State.STARTED: [State.CONSTRUCTING],
        State.CONSTRUCTING: [State.CONSTRUCTED, State.ERROR],
        State.CONSTRUCTED: [State.TX, State.CONSTRUCTING],
        State.TX: [State.ABORT, State.COMMIT, State.ERROR],
        State.ABORT: [State.OK, State.ERROR],
        State.COMMIT: [State.OK, State.ERROR],
        State.OK: [State.TX, State.CONSTRUCTING],
        State.ERROR: [State.TX, State.CONSTRUCTING]
    }
}

phantoms = [ State.EVENT ]