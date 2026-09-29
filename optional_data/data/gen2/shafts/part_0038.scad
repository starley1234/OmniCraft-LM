$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 50, 40, 25, 20, 10 mm, 90 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 50;                  // step 1 diameter
len1 = 25;                // step 1 length
d2 = 40;                  // step 2 diameter
len2 = 20;                // step 2 length
d3 = 25;                  // step 3 diameter
len3 = 25;                // step 3 length
d4 = 20;                  // step 4 diameter
len4 = 10;                // step 4 length
d5 = 10;                  // step 5 diameter
len5 = 10;                // step 5 length
total = 90;               // overall length
chamfer = 1;              // end chamfer
groove_r = 20;            // groove radius
groove_z = 27;            // groove position from the end
groove_w = 3.5;           // groove width
groove_d = 2;             // groove depth

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [25 - chamfer, 0], [25, chamfer], [25, 25], [20, 25], [20, 45], [12.5, 45], [12.5, 70], [10, 70], [10, 80], [5, 80], [5, 89], [4, 90], [0, 90]];

difference() {
  rotate_extrude() polygon(profile);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 1, groove_w]);
}
