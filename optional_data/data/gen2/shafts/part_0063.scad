$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 30, 20, 12, 10, 8 mm, 115 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 30;                  // step 1 diameter
len1 = 20;                // step 1 length
d2 = 20;                  // step 2 diameter
len2 = 15;                // step 2 length
d3 = 12;                  // step 3 diameter
len3 = 25;                // step 3 length
d4 = 10;                  // step 4 diameter
len4 = 15;                // step 4 length
d5 = 8;                   // step 5 diameter
len5 = 40;                // step 5 length
total = 115;              // overall length
chamfer = 1.5;            // end chamfer
groove_r = 5;             // groove radius
groove_z = 62;            // groove position from the end
groove_w = 2;             // groove width
groove_d = 1;             // groove depth
key_w = 5;                // keyway width
key_d = 2.5;              // keyway depth
key_len = 14;             // keyway length
key_z = 98;               // keyway start along the shaft

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [15 - chamfer, 0], [15, chamfer], [15, 20], [10, 20], [10, 35], [6, 35], [6, 60], [5, 60], [5, 75], [4, 75], [4, 113.5], [2.5, 115], [0, 115]];

difference() {
  rotate_extrude() polygon(profile);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 1, groove_w]);
  /* keyway milled into the top of the largest step */
  translate([d1 / 2 - key_d, -key_w / 2, key_z]) cube([key_d + 1, key_w, key_len]);
}
