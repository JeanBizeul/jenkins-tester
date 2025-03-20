##
## EPITECH PROJECT, 2025
## day01-am
## File description:
## Makefile
##

## DEFS - Set your project infos and compilation preferences

NAME		=	test
CC			=	gcc
CCFLAGS		=	-Wall -Wextra
DFLAGS		=	-MMD -MF $(@:.o=.d)
LDFLAGS		=

## SRC - Put your sources files here

FILE_EXTENSION	=	.c
INCLUDE_PATH	=	./include

SRCS		=

MAIN		=	main.c

TEST_OUTPUT	=	unit_tests

SRCS_TEST	=
## OBJS

OBJS		=	$(addprefix objs/, ${SRCS:$(FILE_EXTENSION)=.o})
OBJ_MAIN	=	$(addprefix objs/, ${MAIN:$(FILE_EXTENSION)=.o})
OBJS_TEST	=	$(addprefix objs/, ${SRCS_TEST:$(FILE_EXTENSION)=.o})
DEPS		=	$(addprefix objs/, ${SRCS:$(FILE_EXTENSION)=.d})
DEPS_MAIN	=	$(addprefix objs/, ${MAIN:$(FILE_EXTENSION)=.d})

## RULES

all: $(NAME)

-include $(DEPS) $(DEPS_MAIN)

$(NAME):	$(OBJS) $(OBJ_MAIN)
	$(CC) $(CCFLAGS) $(DFLAGS) $(OBJS) $(OBJ_MAIN) -o $@ -I $(INCLUDE_PATH)

objs/%.o:	%$(FILE_EXTENSION)
	mkdir -p $(dir $@)
	$(CC) $(CCFLAGS) $(DFLAGS) -c $< -o $@ -I $(INCLUDE_PATH)

clean:
	rm -rf objs *.gcda *.gcno

fclean:		clean
	rm -rf $(NAME) $(TEST_OUTPUT)

re:		fclean all

tests_run: title $(OBJS) $(OBJS_TEST)
	$(CC) -o $(TEST_OUTPUT) $(SRCS) $(OBJS_TEST) --coverage -lcriterion
	./$(TEST_OUTPUT)

tests_coverage:	tests_run
	gcovr

.PHONY:	all clean fclean re tests_run tests_coverage
