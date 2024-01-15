package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func main() {
	total, err := calculateTotal("./input.txt")
	if err != nil {
		fmt.Println("Error:", err)
		return
	}
	fmt.Println("Total sum of calibration values:", total)
}

func calculateTotal(filePath string) (int, error) {
	file, err := os.Open(filePath)
	if err != nil {
		return 0, err
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	total := 0

	for scanner.Scan() {
		line := scanner.Text()
		firstDigit, lastDigit, err := findFirstAndLastDigit(line)
		if err != nil {
			continue
		}
		value, _ := strconv.Atoi(firstDigit + lastDigit)
		total += value
	}

	return total, scanner.Err()
}

func findFirstAndLastDigit(line string) (string, string, error) {
	var firstDigit, lastDigit string

	for _, char := range line {
		if char >= '0' && char <= '9' {
			if firstDigit == "" {
				firstDigit = string(char)
			}
			lastDigit = string(char)
		}
	}

	if firstDigit == "" || lastDigit == "" {
		return "", "", fmt.Errorf("valid digits not found")
	}

	return firstDigit, lastDigit, nil
}
