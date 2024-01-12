lint: remark
.PHONY: lint

remark: npm
	@npm run remark-lint
.PHONY: remark

format: npm
	@npm run remark-format
.PHONY: format

init: npm pre-commit
.PHONY: init

npm: node_modules/remark-cli/cli.js
.PHONY: npm

pre-commit: .git/hooks/pre-commit
.PHONY: pre-commit

node_modules/remark-cli/cli.js:
	npm install

.git/hooks/pre-commit: bin/pre-commit npm
	cp bin/pre-commit .git/hooks
