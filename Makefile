RM					:= rm -rf
DOCKER				:= docker
COMPOSE				:= $(DOCKER) compose
MKDIR				:= mkdir -p
SHARE_DIR			:= Shared


.PHONY:				build clean clean_docker run

run:				$(SHARE_DIR)
	$(COMPOSE) run -it attack_env

$(SHARE_DIR):
	$(MKDIR) $(SHARE_DIR)

clean:				clean_docker

clean_docker:
	$(COMPOSE) kill
	@echo
	$(DOCKER) network prune -f
	$(DOCKER) volume prune -f
	$(DOCKER) system prune -af

re:			clean run

