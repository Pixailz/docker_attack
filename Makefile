SHARE_DIR			:= Shared

ifeq ($(DEBUG),)
COMPOSE_TARGET		:= attack_env
else
COMPOSE_TARGET		:= attack_env
endif

RE_STR				:=

ifeq ($(findstring re,$(MAKECMDGOALS)),re)
RE_STR				:= --no-cache
endif

.PHONY:				run re build $(SHARE_DIR)

run:				build
	xhost +local:
	docker compose run -it $(COMPOSE_TARGET)
	xhost -local:

up:					build
	docker compose up $(COMPOSE_TARGET)

build:				$(SHARE_DIR)
	docker compose build $(COMPOSE_TARGET) $(RE_STR)

re:					run

$(SHARE_DIR):
	$(shell [ -d $(SHARE_DIR) ] || mkdir -p $(SHARE_DIR))
	$(shell [ -d $(SHARE_DIR)/home ] || mkdir -p $(SHARE_DIR)/home)
