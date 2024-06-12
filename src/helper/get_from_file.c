/*
** EPITECH PROJECT, 2024
** my_teams
** File description:
** src/helper/get_from_file.c
*/

#include "myteams.h"

char *get_from_file(const char *filename)
{
    int fd = open(filename, O_RDONLY);
    char *buffer = NULL;
    struct stat st;
    int size = 0;

    if (fd == -1)
        return NULL;
    stat(filename, &st);
    size = st.st_size;
    buffer = malloc(sizeof(char) * (size + 1));
    if (buffer == NULL)
        return NULL;
    read(fd, buffer, size);
    buffer[size] = '\0';
    close(fd);
    return buffer;
}

