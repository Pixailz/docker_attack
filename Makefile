RM					:= rm -rf
DOCKER				:= docker
COMPOSE				:= $(DOCKER) compose
MKDIR				:= mkdir -p
SHARE_DIR			:= Shared

ifeq ($(DEBUG),1)
COMPOSE_TARGET		:= attack_env
else
COMPOSE_TARGET		:= attack_env
endif

.PHONY:				build clean clean_docker run $(SHARE_DIR)

run:				$(SHARE_DIR)
	$(COMPOSE) run -it $(COMPOSE_TARGET)

$(SHARE_DIR):
	$(shell [ -d $(SHARE_DIR) ] || $(MKDIR) $(SHARE_DIR))
	$(shell [ -d $(SHARE_DIR)/home ] || $(MKDIR) $(SHARE_DIR)/home)

clean:				clean_docker

clean_docker:
	$(COMPOSE) kill
	@echo
	$(DOCKER) network prune -f
	$(DOCKER) volume prune -f
	$(DOCKER) system prune -af

re:			clean run

