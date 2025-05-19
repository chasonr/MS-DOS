/* errtst.h */

#ifndef ERRTST_H
#define ERRTST_H

struct findType;

char fPathErr(char *p);
int strpre(char *pre, char *tot);
void Fatal(char *p);
int ffirst(char *pb, int attr, struct findType *pfbuf);
int fnext(struct findType *pfbuf);
char *strbscan(char *str, char *class);
int curdir(char *dst, int drive);
int rootpath(char *relpath, char *fullpath);
char getdrv(void);
int testkanj(unsigned char c);

#endif
