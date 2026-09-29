$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 40, 30, 14, 10, 8 mm, 130 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 40;                  // step 1 diameter
len1 = 25;                // step 1 length
d2 = 30;                  // step 2 diameter
len2 = 30;                // step 2 length
d3 = 14;                  // step 3 diameter
len3 = 40;                // step 3 length
d4 = 10;                  // step 4 diameter
len4 = 10;                // step 4 length
d5 = 8;                   // step 5 diameter
len5 = 25;                // step 5 length
total = 130;              // overall length
chamfer = 1.5;            // end chamfer
groove_r = 7;             // groove radius
groove_z = 57;            // groove position from the end
groove_w = 2;             // groove width
groove_d = 1;             // groove depth
cross_d = 5;              // cross pin hole
cross_z = 117.5;          // cross hole position

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [20 - chamfer, 0], [20, chamfer], [20, 25], [15, 25], [15, 55], [7, 55], [7, 95], [5, 95], [5, 105], [4, 105], [4, 128.5], [2.5, 130], [0, 130]];

difference() {
  rotate_extrude() polygon(profile);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 1, groove_w]);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d5 + 4, d = cross_d, center = true);
}
