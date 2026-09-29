$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 30, 16, 10, 8 mm, 115 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 30;                  // step 1 diameter
len1 = 40;                // step 1 length
d2 = 16;                  // step 2 diameter
len2 = 25;                // step 2 length
d3 = 10;                  // step 3 diameter
len3 = 10;                // step 3 length
d4 = 8;                   // step 4 diameter
len4 = 40;                // step 4 length
total = 115;              // overall length
chamfer = 2;              // end chamfer
groove_r = 8;             // groove radius
groove_z = 42;            // groove position from the end
groove_w = 2.5;           // groove width
groove_d = 1;             // groove depth
cross_d = 5;              // cross pin hole
cross_z = 95;             // cross hole position

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [15 - chamfer, 0], [15, chamfer], [15, 40], [8, 40], [8, 65], [5, 65], [5, 75], [4, 75], [4, 113], [2, 115], [0, 115]];

difference() {
  rotate_extrude() polygon(profile);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 1, groove_w]);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d4 + 4, d = cross_d, center = true);
}
