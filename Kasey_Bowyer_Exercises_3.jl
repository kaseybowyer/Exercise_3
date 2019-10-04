cd("/Users/kaseybowyer/Documents/Courses/Fall2019/Neu314/Exercises/Exercise_3")

using Plots
using PyPlot
using JLD

# Part 1Aa
image = imread("el-capitan.png")
imshow(image)

size(image)


# Part 1Ab
"""
extract_RBG -- takes in a filename that is a string and is an image.
extract_RBG loads this image, shows this image, and then extracts the
red, blue, and green values of the #rows x #columns matrix and stores
the values in three matrices of the same size. The function then returns
those matrices.

Args:
   filename (string): name of the file that will be loaded, shown and the
                      RBG values extracted from.

Returns:
   red (Float64 matrix): the red values of the image
   blue (Float64 matrix): the blue values of the image
   green (Float64 matrix): the green values of the image
"""

function extract_RBG(filename)
    # loading image file
    image = imread(filename)

    # displaying image
    imshow(image)

    # extracting the color values from the image and putting in respective arrays
    red = zeros(Float64, size(image,1), size(image,2))
    green = zeros(Float64, size(image,1), size(image,2))
    blue = zeros(Float64, size(image,1), size(image,2))

    for i = 1:size(image,1)
        for j = 1:size(image,2)
            global red[i,j] = image[i,j,1]
            global green[i,j] = image[i,j,2]
            global blue[i,j] = image[i,j,3]
        end
    end

    println("Reset with git reset --mixed")

    return red, green, blue
end

# Part 1Ae
# switching the red, green and blue values to green, blue and red
image2 = zeros(360, 640, 3)
filename = "el-capitan.png"
redvals, greenvals, bluevals = extract_RBG(filename)
image2[:,:,1] = greenvals
image2[:,:,2] = bluevals
image2[:,:,3] = redvals

figure(figsize=[8,5])
subplot(1,2,1)
imshow(image)
title("El-Capitan Regular Image")
axis("off")
subplot(1,2,2)
imshow(image2)
title("El-Capitan with Shifted RBG values")
axis("off")

# Part 1B
function circ_rotation(filename, p)
    image = imread(filename)
    image_copy = image[:,:,1]

    num_rows = size(image_copy,1)
    # making sure shift isn't larger than number of rows and shifts are redundant
    p = p%num_rows

    for i = 1:num_rows
        if i - p < 1
            image[num_rows+i-p,:,1] =  image_copy[i,:,1]
        else
            image[i-p,:,1] = image_copy[i,:,1]
        end
    end

    return image

end

function circ_matrix(matrix, p)
    matrix_copy = matrix[:,:]

    num_rows = size(matrix_copy,1)
    # making sure shift isn't larger than number of rows and shifts are redundant
    p = p%num_rows

    for i = 1:num_rows
        if i - p < 1
            matrix[num_rows+i-p,:] =  matrix_copy[i,:]
        else
            matrix[i-p,:] = matrix_copy[i,:]
        end
    end

    return matrix

end

circ_image =  circ_rotation(filename,180)
imshow(circ_image)
