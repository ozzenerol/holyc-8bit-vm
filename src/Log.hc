/**
* Extremely plain Logging file.
* It is not thread safe in any way, but I don't care since we are not using, for now, multithreading in this VM.
*
* @author Lorenzo Orlando
*/

U0 LogInfo(U8 *fmt, ...)
{
    U8 *msg = StrPrintJoin(NULL, fmt, argc, argv);
    "[INFO] %s\n", msg;
    Free(msg);
}

U0 LogWarn(U8 *fmt, ...)
{
    U8 *msg = StrPrintJoin(NULL, fmt, argc, argv);
    "[WARN] %s\n", msg;
    Free(msg);
}

U0 LogError(U8 *fmt, ...)
{
    U8 *msg = StrPrintJoin(NULL, fmt, argc, argv);
    "[ERROR] %s\n", msg;
    Free(msg);
}
