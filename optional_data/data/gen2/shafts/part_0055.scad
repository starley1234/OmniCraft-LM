$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 40, 25, 16, 12, 8 mm, 100 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 40;                  // step 1 diameter
len1 = 20;                // step 1 length
d2 = 25;                  // step 2 diameter
len2 = 40;                // step 2 length
d3 = 16;                  // step 3 diameter
len3 = 10;                // step 3 length
d4 = 12;                  // step 4 diameter
len4 = 10;                // step 4 length
d5 = 8;                   // step 5 diameter
len5 = 20;                // step 5 length
total = 100;              // overall length
chamfer = 1;              // end chamfer
groove_r = 8;             // groove radius
groove_z = 62;            // groove position from the end
groove_w = 2;             // groove width
groove_d = 1;             // groove depth
key_w = 8;                // keyway width
key_d = 4;                // keyway depth
key_len = 14;             // keyway length
key_z = 83;               // keyway start along the shaft
cross_d = 5;              // cross pin hole
cross_z = 90;             // cross hole position

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [20 - chamfer, 0], [20, chamfer], [20, 20], [12.5, 20], [12.5, 60], [8, 60], [8, 70], [6, 70], [6, 80], [4, 80], [4, 99], [3, 100], [0, 100]];

difference() {
  rotate_extrude() polygon(profile);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 1, groove_w]);
  /* keyway milled into the top of the largest step */
  translate([d1 / 2 - key_d, -key_w / 2, key_z]) cube([key_d + 1, key_w, key_len]);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d5 + 4, d = cross_d, center = true);
}
