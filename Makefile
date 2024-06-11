##
## EPITECH PROJECT, 2024
## my_teams
## File description:
## Makefile
##

BUILD_DIR	:= build
BASE		:= src

SRC 	:= $(addprefix $(BASE)/, $(addsuffix .c,			\
				main                                        \
			))

OBJ       := $(patsubst $(BASE)/%.c, $(BUILD_DIR)/%.o, $(SRC))

CC        := gcc
CFLAGS    := -I include -Wall -Wextra -Wformat -Wshadow

CRITERION := tests/testing.c
NAME      := my_teams
UNIT_TEST_NAME := unit_tests

# Phony targets
.PHONY: all clean fclean re compile_test tests_run

all: $(NAME)

$(NAME): $(OBJ)
	@ $(CC) -o $(NAME) $^ $(CFLAGS)

MAX_FILES := $(words $(SRC))
COUNT     := 0

$(BUILD_DIR)/%.o: $(BASE)/%.c | create_dirs
	$(eval COUNT=$(shell echo $$(($(COUNT) + 1))))
	@$(CC) $(CFLAGS) -c $< -o $@
	@ python3 bar.py --stepno=$(COUNT) --nsteps=$(MAX_FILES)
	@-echo -e '\nCompiling\t\t\t$@                                  '
	@-echo -e '\033[A\033[A\033[A'

DIRS		:= $(sort $(dir $(patsubst $(BASE)/%, $(BUILD_DIR)/%,\
				$(basename $(SRC)))))

create_dirs:
	$(shell mkdir -p $(DIRS))

fclean: clean
	@rm -f $(NAME)
	@rm -f $(UNIT_TEST_NAME)
	@rm -rf $(BUILD_DIR)

re: fclean all

compile_test:
	$(CC) -o $(UNIT_TEST_NAME) $(CRITERION) $(CFLAGS) --coverage -lcriterion -g

tests_run: fclean compile_test
	./$(UNIT_TEST_NAME)
	gcovr --exclude tests/
	gcovr --exclude tests/ --branches

