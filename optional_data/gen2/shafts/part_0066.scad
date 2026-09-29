$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 40, 30, 20, 16, 12 mm, 140 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 40;                  // step 1 diameter
len1 = 20;                // step 1 length
d2 = 30;                  // step 2 diameter
len2 = 25;                // step 2 length
d3 = 20;                  // step 3 diameter
len3 = 25;                // step 3 length
d4 = 16;                  // step 4 diameter
len4 = 30;                // step 4 length
d5 = 12;                  // step 5 diameter
len5 = 40;                // step 5 length
total = 140;              // overall length
chamfer = 1.5;            // end chamfer
groove_r = 8;             // groove radius
groove_z = 72;            // groove position from the end
groove_w = 2.5;           // groove width
groove_d = 1.3;           // groove depth
cross_d = 4;              // cross pin hole
cross_z = 120;            // cross hole position

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [20 - chamfer, 0], [20, chamfer], [20, 20], [15, 20], [15, 45], [10, 45], [10, 70], [8, 70], [8, 100], [6, 100], [6, 138.5], [4.5, 140], [0, 140]];

difference() {
  rotate_extrude() polygon(profile);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 1, groove_w]);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d5 + 4, d = cross_d, center = true);
}
