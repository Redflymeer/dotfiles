#include <iostream>
#include <cstdlib>
#include <string>
#include <cctype>

int main () {
  // Interface 
  std::string interface;
  std::string mkwith;

  
  std::cout << "What interface do you want turn off/turn on? (basicly eth1/eth0/wlan0) ";
  std::getline(std::cin, interface);
  std::cout << "What you make with " << interface << " (down or up) ";
  std::getline(std::cin, mkwith);


  if (interface == "eth0") {
    if (mkwith == "up") {
      system("doas ip link set eth0 up");
      std::cout << "Succeful!\n";
      return 0;
    } else if (mkwith == "down") {
      system("doas ip link set eth0 down");
      std::cout << "Succeful!\n";
      return 0;
    } else {
      std::cerr;
      return 1;
    }
  } else if (interface == "eth1") {
     if (mkwith == "up") {
      system("doas ip link set eth1 up");
      std::cout << "Succeful!\n";
      return 0;
    } else if (mkwith == "down") {
      system("doas ip link set eth1 down");
      std::cout << "Succeful!\n";
      return 0;
    } else {
      std::cerr;
      return 1;
    } 

  } else if (interface == "wlan0") {
    if (mkwith == "up") {
      system("doas ip link set wlan0 up");
      std::cout << "Succeful!\n";
      return 0;
    } else if (mkwith == "down") {
      system("doas ip link set wlan0 down");
      std::cout << "Succeful!\n";
      return 0;
    } else {
      std::cerr;
      return 1;
    }
  } else {
    std::cerr;
  }
}
