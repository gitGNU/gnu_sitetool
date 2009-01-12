contents = {
	content = {
		id      = "p1_body";
		source  = "index.scm";
		filters = {
			filter[0] = {
				source      = "sxml";
				destination = "sxml";
				parameters  = "";
			};
		};
	};

	content = {
		id      = "p1_map";
		source  = "@work_dir@/maps/p1.map";
		filters = {
			filter[0] = {
				source      = "map";
				destination = "sxml";
				parameters  = "-l menu.scm -l ../../libs/scheme/tree.scm";
			};
		};
	};

	content = {
		id      = "p2_body";
		source  = "grammar.scm";
		filters = {
			filter[0] = {
				source      = "sxml";
				destination = "sxml";
				parameters  = "";
			};
		};
	};

	content = {
		id      = "p2_map";
		source  = "@work_dir@/maps/p2.map";
		filters = {
			filter[0] = {
				source      = "map";
				destination = "sxml";
				parameters  = "-l menu.scm -l ../../libs/scheme/tree.scm";
			};
		};
	};

        content = {
                id     = "footer";
                source = "./footer.sxml";
                filters = {
                        filter[0] = {
                                source      = "sxml";
                                destination = "sxml";
                                parameters  = "";
                        };
                };
        };

        content = {
                id     = "header";
                source = "./header.sxml";
                filters = {
                        filter[0] = {
                                source      = "sxml";
                                destination = "sxml";
                                parameters  = "";
                        };
                };
        };
};
