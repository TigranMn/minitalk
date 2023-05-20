NAME_CLIENT			= client
NAME_SERVER			= server

SRC_DIR			= src
OBJ_DIR			= obj

SRC_CLIENT 		= $(addprefix $(SRC_DIR)/, client.c)
SRC_SERVER 		= $(addprefix $(SRC_DIR)/, server.c)

OBJ_CLIENT 		= $(addprefix $(OBJ_DIR)/, client.o)
OBJ_SERVER 		= $(addprefix $(OBJ_DIR)/, server.o)

SERVER_OBJS		= $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SRC_SERVER))
CLIENT_OBJS		= $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SRC_CLIENT))
CC				= cc
RM				= rm -rf
# CFLAGS			= -Wall -Wextra -Werror

all: $(CLIENT_OBJS) $(CLIENT_OBJS) $(NAME_CLIENT) $(NAME_SERVER) Makefile

bonus: all

$(NAME_CLIENT): $(CLIENT_OBJS)
	$(CC) $(CFLAGS) -o $(NAME_CLIENT) $(OBJ_CLIENT)

$(NAME_SERVER): $(SERVER_OBJS)
	$(CC) $(CFLAGS) -o $(NAME_SERVER) $(OBJ_SERVER) 

$(OBJ_DIR)/%.o:	$(SRC_DIR)/%.c
	mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@ 

clean:			
	$(RM) $(OBJ_DIR)

fclean:	clean
	$(RM) $(NAME_CLIENT)
	$(RM) $(NAME_SERVER)

re:	fclean all bonus

.PHONY:	all clean fclean re bonus