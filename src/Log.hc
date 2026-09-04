/**
* Extremely plain Logging file.
* It is not thread safe in any way, but I don't care since we are not using, for now, multithreading in this VM.
*
* @author Lorenzo Orlando
*/

class LogConfig {
    Bool debug;
    Bool info;
    Bool warn;
    Bool error;
};

private LogConfig *cfg;

/* If you don't call this function at the beginning of your program, you are fucked */
U0 LogInit(Bool debug, Bool info, Bool warn, Bool error) {
    LogConfig *temp_cfg = malloc(sizeof(LogConfig));
    if (!temp_cfg) {
        throw("What the fuck even happened");
    }

    cfg = temp_cfg;

    cfg->debug = debug;
    cfg->info = info;
    cfg->warn = warn;
    cfg->error = error;
}

U0 LogDebug(U8 *fmt, ...)
{
    if (cfg->debug) {
        U8 *msg = StrPrintJoin(NULL, fmt, argc, argv);
        "[DEBUG] %s\n", msg;
        Free(msg);
    }
}

U0 LogInfo(U8 *fmt, ...)
{
    if (cfg->info) {
        U8 *msg = StrPrintJoin(NULL, fmt, argc, argv);
        "[INFO] %s\n", msg;
        Free(msg);
    }
}

U0 LogWarn(U8 *fmt, ...)
{
    if (cfg->warn) {
        U8 *msg = StrPrintJoin(NULL, fmt, argc, argv);
        "[WARN] %s\n", msg;
        Free(msg);
    }
}

U0 LogError(U8 *fmt, ...)
{
    if (cfg->error) {
        U8 *msg = StrPrintJoin(NULL, fmt, argc, argv);
        "[ERROR] %s\n", msg;
        Free(msg);
    }
}
