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
		id     = "variables_body";
		source = "variables.page";
		filters = {
			filter[0] = {
				source      = "sxml";
				destination = "sxml";
				parameters  = "";
			};
		};
	};
	content = {
		id     = "variables_map";
		source = "@work_dir@/maps/variables.map";
		filters = {
			filter[0] = {
				source      = "map";
				destination = "sxml";
				parameters  = "-l ./menu.scm";
			};
		};
	};

	content = {
		id     = "filters_body";
		source = "filters.page";
		filters = {
			filter[0] = {
				source      = "sxml";
				destination = "sxml";
				parameters  = "";
			};
		};
	};
	content = {
		id     = "filters_map";
		source = "@work_dir@/maps/filters.map";
		filters = {
			filter[0] = {
				source      = "map";
				destination = "sxml";
				parameters  = "-l ./menu.scm";
			};
		};
	};

	content = {
		id      = "filters_wikitext_body";
		source  = "wikitext.page";
		filters = {
			filter[0] = {
				source      = "wiki";
				destination = "sxml";
				parameters  = "";
			};
		};
	};
	content = {
		id      = "filters_wikitext_map";
		source  = "@work_dir@/maps/filters-wikitext.map";
		filters = {
			filter[0] = {
				source      = "map";
				destination = "sxml";
				parameters  = "-l ./menu.scm";
			};
		};
	};

	content = {
		id      = "alfa_body";
		source  = "level1/test1.page";
		filters = {
			filter[0] = {
				source      = "changelog";
				destination = "wiki";
				parameters  = "";
			};
			filter[1] = {
				source      = "wiki";
				destination = "sxml";
				parameters  = "";
			};
		};
	};
	content = {
		id      = "alfa_map";
		source  = "@work_dir@/maps/p1.map";
		filters = {
			filter[0] = {
				source      = "map";
				destination = "sxml";
				parameters  = "-l ./menu.scm";
			};
		};
	};

	content = {
		id      = "p2_body";
		source  = "level1/level1/test11-1.page";
		filters = {
			filter[0] = {
				source      = "changelog";
				destination = "wiki";
				parameters  = "";
			};
			filter[1] = {
				source      = "wiki";
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
				parameters  = "-l ./menu.scm";
			};
		};
	};

	content = {
		id      = "p3_body";
		source  = "level1/level1/test11-2.page";
		filters = {
			filter[0] = {
				source      = "changelog";
				destination = "wiki";
				parameters  = "";
			};
			filter[1] = {
				source      = "wiki";
				destination = "sxml";
				parameters  = "";
			};
		};
	};
	content = {
		id      = "p3_map";
		source  = "@work_dir@/maps/p3.map";
		filters = {
			filter[0] = {
				source      = "map";
				destination = "sxml";
				parameters  = "-l ./menu.scm";
			};
		};
	};

	content = {
		id      = "p4_body";
		source  = "level1/level1/test11-3.page";
		filters = {
			filter[0] = {
				source      = "changelog";
				destination = "wiki";
				parameters  = "";
			};
			filter[1] = {
				source      = "wiki";
				destination = "sxml";
				parameters  = "";
			};
		};
	};
	content = {
		id      = "p4_map";
		source  = "@work_dir@/maps/p4.map";
		filters = {
			filter[0] = {
				source      = "map";
				destination = "sxml";
				parameters  = "-l ./menu.scm";
			};
		};
	};

	content = {
		id      = "p5_body";
		source  = "level1/level2/test12.page";
		filters = {
			filter[0] = {
				source      = "sxml";
				destination = "sxml";
				parameters  = "";
			};
		};
	};
	content = {
		id      = "p5_map";
		source  = "@work_dir@/maps/p5.map";
		filters = {
			filter[0] = {
				source      = "map";
				destination = "sxml";
				parameters  = "-l ./menu.scm";
			};
		};
	};
		
	content = {
		id      = "p6_body";
		source  = "level1/level2/level1/test121.page";
		filters = {
			filter[0] = {
				source      = "wiki";
				destination = "sxml";
				parameters  = "";
			};
		};
	};
	content = {
		id      = "p6_map";
		source  = "@work_dir@/maps/p6.map";
		filters = {
			filter[0] = {
				source      = "map";
				destination = "sxml";
				parameters  = "-l ./menu.scm";
			};
		};
	};
		
	content = {
		id      = "p7_body";
		source  = "level2/test2.page";
		filters = {
			filter[0] = {
				source      = "news";
				destination = "wiki";
				parameters  = "";
			};
			filter[1] = {
				source      = "wiki";
				destination = "sxml";
				parameters  = "";
			};
		};
	};
	content = {
		id      = "p7_map";
		source  = "@work_dir@/maps/p7.map";
		filters = {
			filter[0] = {
				source      = "map";
				destination = "sxml";
				parameters  = "-l ./menu.scm";
			};
		};
	};

	content = {
		id      = "p8_body";
		source  = "index.page";
		filters = {
			filter[0] = {
				source      = "wiki";
				destination = "sxml";
				parameters  = "";
			};
		};
	};
	content = {
		id      = "p8_map";
		source  = "@work_dir@/maps/p8.map";
		filters = {
			filter[0] = {
				source      = "map";
				destination = "sxml";
				parameters  = "-l ./menu.scm";
			};
		};
	};

	content = {
		id      = "p10_body";
		source  = "changelog.page";
		filters = {
			filter[0] = {
				source      = "changelog";
				destination = "wiki";
				parameters  = "";
			};
			filter[1] = {
				source      = "wiki";
				destination = "sxml";
				parameters  = "";
			};
		};
	};
	content = {
		id      = "p10_map";
		source  = "@work_dir@/maps/p10.map";
		filters = {
			filter[0] = {
				source      = "map";
				destination = "sxml";
				parameters  = "-l ./menu.scm";
			};
		};
	};

	content = {
		id      = "p11_body";
		source  = "svnlog.page";
		filters = {
			filter[0] = {
				source      = "svnlog";
				destination = "wiki";
				parameters  = "";
			};
			filter[1] = {
				source      = "wiki";
				destination = "sxml";
				parameters  = "";
			};
		};
	};
	content = {
		id      = "p11_map";
		source  = "@work_dir@/maps/p11.map";
		filters = {
			filter[0] = {
				source      = "map";
				destination = "sxml";
				parameters  = "-l ./menu.scm";
			};
		};
	};
};
