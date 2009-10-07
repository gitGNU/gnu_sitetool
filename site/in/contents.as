contents = {
	content = {
		id      = "1-body";
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
		id      = "1-map";
		source  = "@work_dir@/maps/1.map";
		filters = {
			filter[0] = {
				source      = "map";
				destination = "sxml";
				parameters  = "";
			};
		};
	};

	content = {
		id      = "1.1-body";
		source  = "news.sxml";
		filters = {
			filter[0] = {
				source      = "sxml";
				destination = "sxml";
				parameters  = "";
			};
		};
	};

	content = {
		id      = "1.1-map";
		source  = "@work_dir@/maps/1.1.map";
		filters = {
			filter[0] = {
				source      = "map";
				destination = "sxml";
				parameters  = "";
			};
		};
	};

	content = {
		id      = "2-body";
		source  = "development.scm";
		filters = {
			filter[0] = {
				source      = "sxml";
				destination = "sxml";
				parameters  = "";
			};
		};
	};

	content = {
		id      = "2-map";
		source  = "@work_dir@/maps/2.map";
		filters = {
			filter[0] = {
				source      = "map";
				destination = "sxml";
				parameters  = "";
			};
		};
	};

	content = {
		id      = "2.1-body";
		source  = "todos.sxml";
		filters = {
			filter[0] = {
				source      = "sxml";
				destination = "sxml";
				parameters  = "";
			};
		};
	};

	content = {
		id      = "2.1-map";
		source  = "@work_dir@/maps/2.1.map";
		filters = {
			filter[0] = {
				source      = "map";
				destination = "sxml";
				parameters  = "";
			};
		};
	};

	content = {
		id      = "3-body";
		source  = "downloads.scm";
		filters = {
			filter[0] = {
				source      = "sxml";
				destination = "sxml";
				parameters  = "";
			};
		};
	};

	content = {
		id      = "3-map";
		source  = "@work_dir@/maps/3.map";
		filters = {
			filter[0] = {
				source      = "map";
				destination = "sxml";
				parameters  = "";
			};
		};
	};

	content = {
		id      = "4-body";
		source  = "installation.scm";
		filters = {
			filter[0] = {
				source      = "sxml";
				destination = "sxml";
				parameters  = "";
			};
		};
	};

	content = {
		id      = "4-map";
		source  = "@work_dir@/maps/4.map";
		filters = {
			filter[0] = {
				source      = "map";
				destination = "sxml";
				parameters  = "";
			};
		};
	};

	content = {
		id      = "5-body";
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
		id      = "5-map";
		source  = "@work_dir@/maps/5.map";
		filters = {
			filter[0] = {
				source      = "map";
				destination = "sxml";
				parameters  = "";
			};
		};
	};

        content = {
                id     = "footer";
                source = "./footer.sxml";
                filters = {
                        filter[0] = {
                                source      = "scm";
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
