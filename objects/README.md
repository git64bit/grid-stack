# Saved Objects

Each printed Grid Stack construct is preserved as one self-contained top-level OpenSCAD recipe.

A saved recipe:

1. imports an explicit versioned API file;
2. asserts the required API version;
3. embeds every geometry-affecting material, nozzle, process, boundary, path, pattern, and stack record;
4. calls exactly one public module: `grid_stack_render()`.

Do not replace explicit records with Customizer selections or mutable catalog lookups. Once a recipe has been printed, preserve it unchanged. A design change creates a new object revision and file.

The API assertion is a compatibility guard. Exact historical implementation is preserved by the Git commit or tag containing the recipe.
