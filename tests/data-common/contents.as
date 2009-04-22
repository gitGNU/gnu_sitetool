contents = {
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

	content = {
		id     = "index-body";
		source = "index.scm";
		filters = {
			filter[0] = {
				source      = "sxml";
				destination = "sxml";
				parameters  = "";
			};
		};
	};
	content = {
		id     = "index-map";
		source = "@work_dir@/maps/index.map";
		filters = {
			filter[0] = {
				source      = "map";
				destination = "sxml";
				parameters  = "";
			};
		};
	};

};
