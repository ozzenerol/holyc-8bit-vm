

U0 Common_ThrowError(U8 *context) {
    if (!context) {
        context = "";
    }

    U8 *msg = Fs->except_ch(U8*);
    LogError("(%s) Caught exception: %s", context, msg);
    Free(msg);
}
