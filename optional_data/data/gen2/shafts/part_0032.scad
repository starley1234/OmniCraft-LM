$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 50, 40, 14, 8 mm, 105 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 50;                  // step 1 diameter
len1 = 25;                // step 1 length
d2 = 40;                  // step 2 diameter
len2 = 40;                // step 2 length
d3 = 14;                  // step 3 diameter
len3 = 15;                // step 3 length
d4 = 8;                   // step 4 diameter
len4 = 25;                // step 4 length
total = 105;              // overall length
chamfer = 1;              // end chamfer
groove_r = 20;            // groove radius
groove_z = 27;            // groove position from the end
groove_w = 3;             // groove width
groove_d = 1.6;           // groove depth
key_w = 4;                // keyway width
key_d = 2;                // keyway depth
key_len = 19;             // keyway length
key_z = 83;               // keyway start along the shaft
cross_d = 4;              // cross pin hole
cross_z = 92.5;           // cross hole position

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [25 - chamfer, 0], [25, chamfer], [25, 25], [20, 25], [20, 65], [7, 65], [7, 80], [4, 80], [4, 104], [3, 105], [0, 105]];

difference() {
  rotate_extrude() polygon(profile);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 1, groove_w]);
  /* keyway milled into the top of the largest step */
  translate([d1 / 2 - key_d, -key_w / 2, key_z]) cube([key_d + 1, key_w, key_len]);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d4 + 4, d = cross_d, center = true);
}
